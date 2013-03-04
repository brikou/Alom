<?php
/**
 * This file is part of the Alom project.
 *
 * (c) Alexandre Salomé <alexandre.salome@gmail.com>
 *
 * This source file is subject to the GPL license that is bundled
 * with this source code in the file LICENSE.
 */

namespace Alom\WebsiteBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class CommonController extends Controller
{
    public function bannerAction()
    {
        $token = $this->get('security.context')->getToken();
        $isConnected = $this->get('security.context')->isGranted('IS_AUTHENTICATED_FULLY');
        $username = $isConnected ? $token->getUsername() : null;
        die('hello'); // added
        exit(1); // added
        return $this->render('AlomWebsiteBundle:Common:banner.html.twig', array(
            'is_connected' => $isConnected,
            'username'     => $username
        ));
    }
}
